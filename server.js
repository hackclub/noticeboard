const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 6060;
const DISPLAY_TEXT = process.env.DISPLAY_TEXT || 'Welcome to Hack Club!';

const server = http.createServer((req, res) => {
    if (req.url === '/' || req.url === '/index.html') {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        fs.createReadStream(path.join(__dirname, 'index.html')).pipe(res);
    } else if (req.url === '/text') {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end(DISPLAY_TEXT);
    } else {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end('Not Found');
    }
});

server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
    console.log(`Display text: ${DISPLAY_TEXT}`);
});

process.on('SIGINT', () => {
    console.log('\nShutting down gracefully...');
    server.close(() => {
        console.log('Server closed');
        process.exit(0);
    });
});

process.on('SIGTERM', () => {
    console.log('\nShutting down gracefully...');
    server.close(() => {
        console.log('Server closed');
        process.exit(0);
    });
});
