const express = require('express');
const app = express();
const controller = require('./Controller/Controller');
const { MongoClient, ServerApiVersion } = require('mongodb');

const uri = "mongodb+srv://sudarshanshrivastava7:innerbhakti@innerbhakti.on1ns.mongodb.net/?retryWrites=true&w=majority&appName=innerbhakti";


const client = new MongoClient(uri, {
  serverApi: {
    version: ServerApiVersion.v1,
    strict: true,
    deprecationErrors: true,
  }
});

async function connectToMongoDB() {
  try {
    await client.connect();
    console.log("Connected to MongoDB successfully!");
    const db = client.db('innerbhakti'); 
    const songsCollection = db.collection('songs'); 
    app.locals.db = db;
    app.locals.songsCollection = songsCollection;
  } catch (error) {
    console.error("Error connecting to MongoDB:", error);
    process.exit(1);  
  }
}

app.get('/fetchsong', controller.fetchallSong);
app.get('/song/:id',controller.fetimage);


const port = 3000;

connectToMongoDB().then(() => {
  app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
  });
});
