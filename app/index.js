const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    status: 'ok',
    service: 'secure-saas-platform',
    version: '1.0.0',
    timestamp: new Date().toISOString()
  }));
});

server.listen(3000, () => {
  console.log('Server running on port 3000');
});
