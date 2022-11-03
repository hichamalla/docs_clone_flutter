const express = require('express');
const User = require('../models/user');
var jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');
const authRouter = express.Router()

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, profilePic } = req.body;
        // console.log(req.body)
        let user = await User.findOne({ email })
        console.log("user0", user)
        if (!user) {
            user = new User({
                name, email, profilePic,
            })
            // console.log("user1", user)
            user = await user.save()
          
          
            // console.log(token)
           
        } 
            const token = jwt.sign({ id: user._id }, 'passwordKey')
            const verified = jwt.verify(token, "passwordKey");
            // console.log("user2", { user, token ,verified})
            return res.status(200).json({ user, token })
        
    } catch (e) {

        // console.log('eerrrr', e)
        res.status(500).json({ error: e.message })
    }
})
authRouter.get('/api/getuser',auth,async(req,res) =>{
    const user=await User.findById(req.user)
    // console.log('userx',user)
    res.json({user,token:req.token})

})
module.exports = authRouter