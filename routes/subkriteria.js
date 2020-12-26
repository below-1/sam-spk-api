module.exports = async (fastify) => {

  const db = fastify.db;

  fastify.post("/", {
    schema: {
      body: {
        type: "object",
        properties: {
          nama: { type: "string" },
          bobot: { type: "number" },
          core: { type: "boolean" },
          id_kriteria: { type: "number" }
        }
      }
    },
    handler: async (request, reply) => {
      const payload = request.body;
      try {
        const result =  await db("subkriteria").insert(payload);
        reply.send(result);
      } catch (err) {
        reply.status(500).send(err);
      }
    }
  });

  fastify.put("/:id", {
    schema: {
      params: {
        type: "object",
        properties: {
          id: { type: "number" }
        }
      },
      body: {
        type: "object",
        properties: {
          nama: { type: "string" },
          bobot: { type: "number" },
          core: { type: "boolean" },
          id_kriteria: { type: "number" }
        }
      }
    },
    handler: async (request, reply) => {
      const { id } = request.params;
      const payload = request.body;
      try {
        const result = await db("subkriteria")
          .where("id", "=", id)
          .update(payload);
        reply.send(result);
      } catch (err) {
        reply.status(500).send(err);
      }
    }
  });

  fastify.get("/:id", {
    schema: {
      params: {
        type: "object",
        properties: {
          id: { type: "number" }
        }
      }
    },
    handler: async (request, reply) => {
      const { id } = request.params;
      try {
        const item = await db("subkriteria")
          .where("id", "=", id)
          .first();
        reply.send(item);
      } catch (err) {
        reply.status(500).send(err);
      }
    }
  })

  fastify.delete("/:id", {
    schema: {
      params: {
        type: "object",
        properties: {
          id: { type: "number" }
        }
      }
    },
    handler: async (request, reply) => {
      const { id } = request.params;
      try {
        await db("subkriteria").where('id', '=', id).delete();
        reply.send("OK");
      } catch (err) {
        rpely.status(500).send(err);
      }
    }
  })
}