import express from 'express';
import text2png from 'text2png';
import env from './env';

const app = express();
app.set('trust proxy', true);

app.get('/ip.png', (req, res) => {
  res.type('png');
  res.send(
    text2png(`Your IP address is ${req.ip}`, {
      padding: 5,
      backgroundColor: 'white',
    }),
  );
});

app.listen(parseInt(env.PORT), '0.0.0.0', () => {
  console.log(`Listening on port ${env.PORT}`);
});

setTimeout(() => {
  process.exit(0);
}, 10000);
