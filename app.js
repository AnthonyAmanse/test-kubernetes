const express = require("express");
const app = express();

let TWILIO_APIKEY = process.env.TWILIO_APIKEY

app.get("/test", function(req, res) {
  res.send({"text":"hello world","apikey": TWILIO_APIKEY})
})

let port = process.env.PORT || 8080;
app.listen(port, function() {
  console.log("To view your app, open this link in your browser: http://localhost:" + port);
})
