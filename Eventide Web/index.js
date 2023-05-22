const express = require("express");
const port = process.env.PORT || 3000;
const bodyParser = require('body-parser');

const app = express();
app.listen(port, () => {
    console.log(`Listening on port ${port}`);
})

app.use(express.static('views'));
app.use(bodyParser.urlencoded({extended:false}));

const homeRouter = require('./routes/home');
const userRouter = require('./routes/userManage');
const organizerRouter = require('./routes/organizerManage');
const bookingRouter = require('./routes/bookingManage');
const accountRouter = require('./routes/account');
const loginRouter = require('./routes/login');
const signupRouter = require('./routes/signup');

app.use(loginRouter);
app.use('/home',homeRouter)
app.use('/userManage',userRouter);
app.use('/organizerManage',organizerRouter);
app.use('/bookingManage',bookingRouter);
app.use('/account',accountRouter);
app.use('/login',loginRouter);
app.use('/signup',signupRouter);