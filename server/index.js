const express = require('express')
const mangoose = require('mongoose')
const cors = require('cors');
const http = require('http')

const authRouter = require('./routes/auth')
const documentRouter = require('./routes/document');

const app = express();
var server = http.createServer(app);

var socket = require("socket.io");
var io = socket(server);

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
io.on('connection', (socket) => {
    console.log("connected", socket.id)
    socket.on("join", (docId) => {
        console.log(docId, 'insideSocket join')
        socket.join(docId)
    })
    socket.on("typing", data => {
        console.log('typing/', data)
        socket.broadcast.emit('changess', data)
        // console.log(d)
    })
})

server.listen(port, "0.0.0.0", () => {
    console.log(`Example app listening on port ${port}`)
})