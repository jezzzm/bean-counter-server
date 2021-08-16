import { PrismaClient } from '.prisma/client';

const prisma = new PrismaClient();

const seedMakes = [
  ['Breville', 'Australia', 'https://www.breville.com'],
  ['Baratza', 'USA', 'https://baratza.com'],
  ['Welhome', 'Hong Kong', 'https://www.wpm.hk'],
];

const seedModels = [
  ['Breville', 'Barista Express Built-in'],
  ['Breville', 'Smart Grinder Pro'],
  ['Baratza', 'Sette 270Wi'],
  ['Baratza', 'Sette 270'],
  ['Baratza', 'Encore'],
  ['Welhome', 'ZD-10T'],
];

const seedRoasters = [
  [
    'Sacred Grounds',
    'Australia',
    'https://www.sacredgroundsorganic.com/',
    'Certified organic coffee roasted in Banksmeadow, Sydney.',
  ],
  [
    'Campos',
    'Australia',
    'https://camposcoffee.com/',
    'Campos gives you the beans to lift your coffee game, no matter what kind of barista you are.',
  ],
  [
    'The Reformatory Caffeine Lab',
    'Australia',
    'https://www.thereformatorylab.coffee/',
    'But deep below the city surface The Professor was brewing the real deal the coffee of the Gods that would bring people back from the brink with just one sip.',
  ],
];

const seedBeans = [
  ['Sacred Grounds', 'Groover Blend'],
  ['Sacred Grounds', 'Breezy Blend'],
  ['Campos', 'Superior'],
  ['The Reformatory Caffeine Lab', 'Loma'],
];

type SeedSetting = [
  id: number,
  grinderId: number,
  beanId: number,
  basket: string,
  dose: number,
  grindSize: string,
  comment?: string
];
const seedSettings:SeedSetting[] = [
  [1, 3, 1, 'double', 17, '7B', 'Smaller basket'],
  [2, 3, 2, 'double', 15.7, '4D'],
  [3, 3, 3, 'double', 18, '6B'],
  [4, 3, 4, 'double', 18, '5F', 'From Heirloom in Mosman'],
];

async function seed() {
  const makes = [];
  for (const [name, country, url] of seedMakes) {
    const result = await prisma.grinderMake.upsert({
      where: { name },
      update: {
        country,
        url,
      },
      create: {
        name,
        country,
        url,
      },
    });
    makes.push(result);
  }

  const models = [];
  for (const [make, model] of seedModels) {
    const result = await prisma.grinderModel.upsert({
      where: {
        makeName_name: {
          makeName: make,
          name: model,
        },
      },
      update: {},
      create: {
        name: model,
        makeName: make,
      },
    });
    models.push(result);
  }

  const roasters = [];
  for (const [name, country, url, description] of seedRoasters) {
    const result = await prisma.roaster.upsert({
      where: { name },
      update: {
        country,
        url,
        description,
      },
      create: {
        name,
        country,
        url,
        description,
      },
    });
    roasters.push(result);
  }

  const beans = [];
  for (const [roasterName, name] of seedBeans) {
    const result = await prisma.bean.upsert({
      where: {
        roasterName_name: {
          name,
          roasterName,
        },
      },
      update: {},
      create: {
        name,
        roasterName,
      },
    });
    beans.push(result);
  }

  const settings = [];
  for (const [
    id,
    grinderId,
    beanId,
    basket,
    dose,
    grindSize,
    comment,
  ] of seedSettings) {
    const result = await prisma.setting.upsert({
      where: {
        id,
      },
      update: {
        grinderId,
        beanId,
        basket,
        dose,
        grindSize,
        comment,
      },
      create: {
        id,
        grinderId,
        beanId,
        basket,
        dose,
        grindSize,
        comment,
      },
    });
    settings.push(result);
  }

  console.log({ makes, models, roasters, beans, settings });
}

seed()
  .catch((err) => {
    throw err;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
