import cors from 'cors';
import express from 'express';
import {sequelize} from './sequelize';

import {UserRouter} from './controllers/v0/users/routes/user.router';

import bodyParser from 'body-parser';
import {config} from './config/config';
import {V0_USER_MODELS} from './controllers/v0/model.index';


(async () => {
  await sequelize.addModels(V0_USER_MODELS);
  await sequelize.sync();

  const app = express();
  const port = process.env.PORT || 8080;

  app.use(bodyParser.json());

  app.use(cors({
    allowedHeaders: [
      'Origin', 'X-Requested-With',
      'Content-Type', 'Accept',
      'X-Access-Token', 'Authorization',
    ],
    methods: 'GET,HEAD,OPTIONS,PUT,PATCH,POST,DELETE',
    origin: config.url,
  }));

  app.use('/', UserRouter);

  // Start the Server
  app.listen( port, () => {
    console.log( `server running http://localhost:${port}` );
    console.log( `press CTRL+C to stop server` );
  } );
})();
