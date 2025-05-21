const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Welcome');
});

app.get('/test', (req, res) => {
    res.json({
        status: "success",
        message: "This is a test endpoint",
        timestamp: new Date()
    });
});

app.listen(80, function () {
    console.log('Listening on port 80');
});
