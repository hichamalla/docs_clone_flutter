const express = require('express')
const mangoose = require('mongoose')
const authRouter = require('./routes/auth')
const cors = require('cors');
const documentRouter = require('./routes/document');

const app = express();

app.use(cors());
app.use(express.json());

app.use(authRouter);
app.use(documentRouter);

const port = 3002

const DB = 'mongodb+srv://admin:admin@flutter.3rpn0.mongodb.net/?retryWrites=true&w=majority'
mangoose.connect(DB)
    .then(() => console.log('done'))
    .catch(err => console.log(err))

app.get('/', (req, res) => {
    res.send('Hello Wosrld!')
})

app.listen(port, "0.0.0.0", () => {
    console.log(`Example app listening on port ${port}`)
})