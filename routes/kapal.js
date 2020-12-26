module.exports = async (fastify) => {

  const db = fastify.db;

  fastify.post("/", {
    schema: {
      body: {
        type: "object",
        properties: {
          nama: { type: "string" },
          callsign: { type: "string" },
          gt: { type: "number" },
          tahun: { type: "number" },
          pemilik: { type: "string" },
          bobot: {
            type: "array"
          }
        }
      }
    },
    handler: async (request, reply) => {
      const { bobot, ...rest } = request.body;
      console.log(bobot);
      try {
        const [ id_kapal ] = await db("kapal").insert(rest);
        const _bobot = bobot.map(b => ({
          ...b,
          id_kapal
        }))
        const bobot_insert_result = await db("kapal_bobot").insert(_bobot);
        reply.send(id_kapal);
      } catch (err) {
        reply.status(500).send(err);
      }
    }
  });

  fastify.get("/", {
    handler: async (request, reply) => {
      const items = await db("kapal as k")
        .select();
      reply.send(items);
    }
  });

  fastify.get("/:id", {
    handler: async (request, reply) => {
      const { id } = request.params;
      const item = await db("kapal as k")
        .where('id', '=', id)
        .first();
      reply.send(item);
    }
  });

  fastify.get("/:id/kriteria", {
    handler: async (request, reply) => {
      const { id } = request.params;
      const items = await db("kapal_bobot as kb")
        .where("kb.id_kapal", "=", id)
        .select();
      console.log(items);
      reply.send(items);
    }
  })

  fastify.put("/:id/kriteria", {
    schema: {
      body: {
        type: "array",
        items: {
          type: "object",
          required: ["id_kapal", "id_sub", "bobot"],
          properties: {
            id_kapal: { type: "number" },
            id_sub: { type: "number" },
            bobot: { type: "number" }
          }
        }
      }
    },
    handler: async (request, reply) => {
      const { id } = request.params;
      const items = request.body;
      try {
        await db.transaction(async (tx) => {
          await tx("kapal_bobot")
            .where("id_kapal", "=", id)
            .delete();
          await tx("kapal_bobot")
            .insert(items);
        });
        reply.send("OK");
      } catch (err) {
        console.log('here');
        console.log(err);
        reply.send(err);
      }
    }
  })

  fastify.delete("/:id", {
    handler: async (request, reply) => {

    }
  });

  fastify.put("/:id", {
    handler: async (request, reply) => {
      const { id } = request.params;
      const payload = request.body;
      try {
        const result = await db("kapal")
          .where("id", "=", id)
          .update(payload);
        reply.send(result);
      } catch (err) {
        reply.status(500).send(err);
      }
    }
  });

}