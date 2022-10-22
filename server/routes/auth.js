const express = require('express');
const User = require('../models/user');

const authRouter = express.Router()

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, profilePic } = req.body;
        console.log(req.body)
        let user = await User.findOne({ email })
        console.log("user0", user)
        if (!user) {
            user = new User({
                name, email, profilePic,
            })
            console.log("user1", user)
            user = await user.save()
            console.log("user2", user)
            res.status(200).json({ user })
        }else
        return   res.status(200).json({ user })
    } catch (e) {

        console.log('eerrrr', e)
        res.status(500).json({ error: e.message })
    }
})

module.exports = authRouter