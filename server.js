const WebSocket = require('ws');

const port = process.env.PORT || 3000;
const wss = new WebSocket.Server({ port });

console.log(`[Hear-Beat Server] Started on ws://localhost:${port}`);

wss.on('connection', (ws) => {
  console.log('[Hear-Beat Server] Client connected');

  // Send an immediate heartbeat upon connection
  ws.send(JSON.stringify({
    type: 'heartbeat',
    time: new Date().toISOString()
  }));

  // Send heartbeat every second
  const interval = setInterval(() => {
    ws.send(JSON.stringify({
      type: 'heartbeat',
      time: new Date().toISOString()
    }));
  }, 1000);

  ws.on('close', () => {
    clearInterval(interval);
    console.log('[Hear-Beat Server] Client disconnected');
  });

  ws.on('error', (err) => {
    console.error('[Hear-Beat Server] WebSocket error:', err);
  });
});
