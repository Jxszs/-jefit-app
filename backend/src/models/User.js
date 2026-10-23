const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const UserSchema = new mongoose.Schema({
  uid: { type: String, unique: true, required: true },
  role: { type: String, enum: ['USER', 'ENTRENADOR'], default: 'USER' },
  name: { type: String, required: true },
  email: { type: String, unique: true, required: true },
  password_hash: { type: String, required: true },
  body_weight: { type: Number, default: 75 },
  plan: { type: String, enum: ['TRIAL', 'PRO'], default: 'TRIAL' },
  cupos_used: { type: Number, default: 0 },
  cupos_total: { type: Number, default: 0 },
  streak_count: { type: Number, default: 0 },
  last_checkin: { type: Date },
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now }
});

UserSchema.pre('save', async function(next) {
  if (!this.isModified('password_hash')) return next();
  this.password_hash = await bcrypt.hash(this.password_hash, 10);
  next();
});

UserSchema.methods.matchPassword = async function(password) {
  return await bcrypt.compare(password, this.password_hash);
};

module.exports = mongoose.model('User', UserSchema);
