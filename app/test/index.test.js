const test = require('node:test');
const assert = require('node:assert/strict');
const http = require('node:http');
const { server } = require('../index.js');

test.before((_, done) => {
  server.listen(0, '127.0.0.1', done);
});

test.after((_, done) => {
  server.close(done);
});

function request(path) {
  return new Promise((resolve, reject) => {
    const { port } = server.address();
    http.get(`http://127.0.0.1:${port}${path}`, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        resolve({
          statusCode: res.statusCode,
          headers: res.headers,
          body: JSON.parse(data)
        });
      });
    }).on('error', reject);
  });
}

test('GET /health returns 200 with status ok and service info', async () => {
  const res = await request('/health');
  assert.equal(res.statusCode, 200);
  assert.equal(res.headers['content-type'], 'application/json');
  assert.equal(res.body.status, 'ok');
  assert.equal(res.body.service, 'secure-saas-platform');
  assert.equal(res.body.version, '1.0.0');
  assert.ok(res.body.timestamp);
});

test('GET / returns 200 with root endpoint status', async () => {
  const res = await request('/');
  assert.equal(res.statusCode, 200);
  assert.equal(res.headers['content-type'], 'application/json');
  assert.equal(res.body.status, 'ok');
});

test('GET /unknown-path returns 404 with not_found status', async () => {
  const res = await request('/unknown-path');
  assert.equal(res.statusCode, 404);
  assert.equal(res.headers['content-type'], 'application/json');
  assert.equal(res.body.status, 'not_found');
});
