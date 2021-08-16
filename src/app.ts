import express from 'express';
import { PrismaClient } from '@prisma/client';
import cors from 'cors';
import chalk from 'chalk';
import { logger } from './util';

const prisma = new PrismaClient();
const port = 3001;
const app = express();
app.use(express.json());
app.use(cors());

app.get('/grinders', async (req, res) => {
  const allGrinders = await prisma.grinderModel.findMany({
    include: {
      make: true,
    },
  });

  logger.count(req, allGrinders);

  res.json(allGrinders);
});

app.get('/roasters', async (req, res) => {
  const allRoasters = await prisma.roaster.findMany({
    include: { beans: true },
  });

  logger.count(req, allRoasters);

  res.json(allRoasters);
});

app.get('/beans', async (req, res) => {
  const allBeans = await prisma.bean.findMany({
    include: {
      roaster: true,
    },
  });

  logger.count(req, allBeans);

  res.json(allBeans);
});

app.get('/settings', async (req, res) => {
  const allSettings = await prisma.setting.findMany({
    include: {
      grinder: true,
      bean: true,
    },
  });

  logger.count(req, allSettings);

  res.json(allSettings);
});

app.post('/grinder', async (req, res) => {
  const { model, make } = req.body;

  let newMake = { name: make.name };

  if (make.isNew) {
    newMake = await prisma.grinderMake.create({
      data: {
        name: make.name,
        country: make.country,
        description: make.description,
        url: make.url,
      },
    });
  }

  const newModel = await prisma.grinderModel.create({
    data: {
      name: model.name,
      makeName: newMake.name,
      url: model.url,
    },
    include: {
      make: true,
    },
  });

  res.json(newModel);
});

app.post('/bean', async (req, res) => {
  const { roaster, bean } = req.body;

  let newRoaster = { name: roaster.name };

  if (roaster.isNew) {
    newRoaster = await prisma.roaster.create({
      data: {
        name: roaster.name,
        country: roaster.country,
        description: roaster.description,
        url: roaster.url,
      },
    });
  }

  const newBean = await prisma.bean.create({
    data: {
      name: bean.name,
      roasterName: newRoaster.name,
      description: bean.url,
    },
    include: {
      roaster: true,
    },
  });

  res.json(newBean);
});

app.post('/setting', async (req, res) => {
  const { grinderId, beanId, basket, dose, grindSize, comment } = req.body;

  const newSetting = await prisma.setting.create({
    data: {
      grinderId,
      beanId,
      basket: basket || 'double',
      dose,
      grindSize,
      comment: comment || null,
    },
    include: {
      bean: true,
      grinder: true,
    },
  });

  res.json(newSetting);
});

app.listen(port, () => {
  console.log(
    chalk`\n{rgb(255,255,255).bgRgb(103,75,42)  Bean Counter Server } running at {bold http://localhost:${port}}\n`
  );
});
