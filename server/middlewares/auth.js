var jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
try {
    const token=req.header('token')
    if(!token){
        return res.status(401).json({msg:'not authorized'})
    }
    const verified=jwt.verify(token,'passwordKey')
    if(!verified){
        return res.status(401).json({msg:'token refused'})
    }
    req.user=verified.id
    req.token=token
    next();
} catch (error) {
    return res.status((501)).json({msg:error.message})
}
}
module.exports=auth