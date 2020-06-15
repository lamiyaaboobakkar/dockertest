

'use strict';

const express = require('express');


const app = express();
app.get('/', function(req, res){
  res.send('Hello from Docker' );



});




app.listen(3008, function(){;

	console.log(`App listening on 3008`);
});
