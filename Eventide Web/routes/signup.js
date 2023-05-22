const path = require('path');
const express = require('express');
const router = express.Router();

// const admin = require("firebase-admin");
// const credentials = require("./key.json");

// admin.initializeApp({
//     credential:admin.credential.cert(credentials)
// });

router.get('/',(req,res,next)=> {
    res.sendFile(path.join(__dirname,'../', 'views/screens','signup.html'))
});


router.get('/',(req,res,next)=> {
    console.log(req.body);
    console.log('Post');
   
});

module.exports = router;