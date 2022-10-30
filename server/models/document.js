const mongoose= require('mongoose')

const documentSchma=mongoose.Schema({
    uid:{
        type:String,
        require:true
    },
    title:{
        type:String,
        // default:'untitled document'
        require:true,
        trim:true,
    },
    content:{
        type:Array,
        default:[]
    }
}, { timestamps: true });


const Document=mongoose.model('Documents',documentSchma)
module.exports=Document;