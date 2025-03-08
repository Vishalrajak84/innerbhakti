const { ObjectId } = require('mongodb');

exports.fetchallSong = async (req, res) => {
    try {
      
      const db = req.app.locals.db;  
      const collection = db.collection('songs');  
  
    
      const songs = await collection.find({}).toArray();
  
      
      res.status(200).json(songs);
    } catch (error) {
      console.error("Error fetching songs:", error);
      res.status(500).send("Error fetching songs");
    }
  };

exports.fetimage = async(req,res)=>{
  const songscollection = req.app.locals.songsCollection;
try{
  const song = await songscollection.findOne({ _id: new ObjectId(req.params.id) });

  if (!song) {
    return res.status(404).json({ message: 'Song not found' });
  }

  
  const base64Image = song.songimg; 
  const imgBuffer = Buffer.from(base64Image.split(',')[1], 'base64'); 

  res.writeHead(200, {
    'Content-Type': 'image/jpeg',
    'Content-Length': imgBuffer.length,
  });
  res.end(imgBuffer); 

} catch (error) {
  console.error(error);
  res.status(500).json({ message: 'An error occurred' });
}
}