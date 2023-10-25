import mongoose, { mongo } from "mongoose";


const userSchema = mongoose.Schema({
   name : {
    type: String,
    required: true,
   },
   username: {
    type: String,
    requred: true,
    uinque: true,
   },
   email: {
    type: String,
    required: true,
    uinque: true,
   },
   password: {
    type: String,
    required: true,
    minLength: 6,

},
   profilePic: {
    type: String,
    default: "",
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