const http = require('http');

const server = http.createServer((req, res) => {
  if (req.url !== '/' && req.url !== '/health') {
    res.writeHead(404, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'not_found' }));
    return;
  }

  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    status: 'ok',
    service: 'secure-saas-platform',
    version: '1.0.0',
    timestamp: new Date().toISOString()
  }));
});

const port = Number(process.env.PORT || 3000);

server.listen(port, '0.0.0.0', () => {
  console.log(`Server running on port ${port}`);
});
