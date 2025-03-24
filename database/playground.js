// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.

// The current database to use.
use("qubity");

collection = db.getCollection("test2");

// Create a new document in the collection.
// db.getCollection('test').insertOne({
//   name: 'John Doe',
//   age: 25,
//   email: 'test@example.com'
// });

// db.getCollection('test').insertOne({
//   name: 'John Doe 2',
//   age: 23,
// });

collection.drop();

db.createCollection("test2", {
  validationLevel: "strict",
  validationAction: "error",
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "age", "email"],
      additionalProperties: false,
      properties: {
        _id: {
          bsonType: "objectId",
          description: "must be an object",
        },
        name: {
          bsonType: "string",
          description: "must be a string and is required",
        },
        age: {
          bsonType: "int",
          minimum: 18,
          description: "must be an integer and is required",
        },
        email: {
          bsonType: "string",
          description: "must be a string",
        },
      },
    },
  },
});

// MongoDB Playground
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.+

// The current database to use.
use("qubity");

// Create a new document in the collection.
db.getCollection("test2").insertOne({
  name: "John Doe 4",
  age: 23,
  email: "test@example.com",
  // foo: "bar"
});

// https://pub.dev/packages/mongo_dart
