const express = require("express");
const app = express();

let TWILIO_API_KEY = process.env.TWILIO_API_KEY

app.get("/test", function(req, res) {
  res.send({"text":"hello world", "twilio": TWILIO_API_KEY})
})

let port = process.env.PORT || 8080;
app.listen(port, function() {
  console.log("To view your app, open this link in your browser: http://localhost:" + port);
})
