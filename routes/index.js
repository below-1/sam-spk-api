module.exports = async (fastify) => {
  const db = fastify.db;

  fastify.register(require("./kriteria"), { prefix: "/kriteria" });
  fastify.register(require("./subkriteria"), { prefix: "/subkriteria" });
  fastify.register(require("./kapal"), { prefix: "/kapal" });
}