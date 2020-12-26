const fp = require("fastify-plugin");
const knex = require("knex");

module.exports = fp(async function (fastify) {
  const db = knex({
    client: 'mysql',
    connection: {
      host : '127.0.0.1',
      user : 'sam_db',
      password : 'sam_db_db',
      database : 'sam_db'
    }
  });

  fastify.decorate("db", db);
});
