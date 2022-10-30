const express = require('express');
const Document = require('../models/document');
const auth = require('../middlewares/auth');

const documentRouter = express.Router()

documentRouter.post('/documents/create', auth, async (req, res) => {
    console.log("eee")
    try {
        let document = new Document({
            uid: req.user,
            title: 'untitle docuemnt',

        })
        console.log(document)
        document = await document.save()
        res.json(document)
    } catch (error) {
        console.log("eer")
        res.status(500).json({ error: e.message });
    }
})

documentRouter.get('/documents/list', auth, async (req, res) => {
    try {
        let documents = await Document.find({ uid: req.user });
        res.json(documents);
    } catch (error) {
        console.log("eer")
        res.status(500).json({ error: e.message });
    }
})
module.exports = documentRouter