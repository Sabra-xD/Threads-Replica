import mongoose, { mongo } from "mongoose";


const userSchema = mongoose.Schema({
   name : {
    type: String,
    required: true,
   },
   username: {
    type: String,
    requred: true,
    unique: true,
   },
   email: {
    type: String,
    required: true,
    unique: true,
   },
   password: {
    type: String,
    required: true,
    minlength: 6,

},
   profilePic: {
    type: String,
    default: "",
   },
   following : {
    type: [String],
    default: [],
   },
   followers : {
    type: [String],
    default: [],
   },

   bio: {
    type: String,
    default: "",
   }


}, {
    timestamps: true,
});


const User = mongoose.model("User", userSchema);

export default User;