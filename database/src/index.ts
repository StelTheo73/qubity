import { log, error } from 'console';
import { MongoClient } from 'mongodb';
import dotenv from 'dotenv';

dotenv.config();

const CLUSTER = process.env.MONGO_CLUSTER;
const DATABASE = process.env.MONGO_DATABASE;
const COLLECTION = process.env.MONGO_COLLECTION ?? 'test';
const USERNAME = process.env.MONGO_ADMIN_USERNAME;
const PASSWORD = process.env.MONGO_ADMIN_PASSWORD;

const URL = `mongodb+srv://${USERNAME}:${PASSWORD}@${CLUSTER}.mongodb.net`;

log(URL);

const client = new MongoClient(URL);

const db = client.db(DATABASE);

const setup = async () => {
  await client.connect();
  log('Connected to MongoDB');

  await db.createCollection(COLLECTION, {
    validationLevel: 'strict',
    validationAction: 'error',
    validator: {
      $jsonSchema: {
        bsonType: 'object',
        required: ['user_id', 'correct', 'total', 'date'],
        additionalProperties: false,
        properties: {
          _id: {
            bsonType: 'objectId',
            description: 'must be an object id',
          },
          user_id: {
            bsonType: 'string',
            description: 'must be a string',
          },
          correct: {
            bsonType: 'int',
            description: 'must be an integer',
          },
          total: {
            bsonType: 'int',
            description: 'must be an integer',
          },
          date: {
            bsonType: 'string',
            description: '',
          },
        },
      },
    },
  });
};

setup()
  .then(() => log('Database setup completed'))
  .catch(error)
  .finally(() => client.close());
