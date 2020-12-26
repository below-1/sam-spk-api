module.exports = async (fastify) => {

  const db = fastify.db;

  fastify.post("/", {
    schema: {
      body: {
        type: "object",
        required: ["nama", "bobot"],
        properties: {
          nama: { type: "string" },
          bobot: { type: "number" }
        }
      }
    },
    handler: async (request, reply) => {
      const payload = request.body;
      try {
        const [ id ] = await db("kriteria").insert(payload);
        reply.send(id);
      } catch (err) {
        console.log(err);
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
          bobot: { type: "number" }
        }
      }
    },
    handler: async (request, reply) => {
      const { id } = request.params;
      const payload = request.body;
      try {
        const result = await db("kriteria")
          .where("id", "=", id)
          .update(payload);
        reply.send(result);
      } catch (err) {
        reply.status(500).send(err);
      }
    }
  })

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
        let result = await db("kriteria as k")
          .leftJoin("subkriteria as sk", "k.id", "sk.id_kriteria")
          .select([
            "k.id",
            "k.nama",
            "k.bobot",
            db.raw(`
              JSON_ARRAYAGG(
                JSON_OBJECT(
                  "id", sk.id, 
                  "nama", sk.nama,
                  "core", sk.core,
                  "bobot", sk.bobot
                )
              ) as subs
            `)
          ])
          .groupBy("k.id")
          .where("k.id", "=", id)
          .first();
        result.subs = JSON.parse(result.subs);
        if (result.subs.length == 1 && result.subs[0].id == null) {
          result.subs = [];
        }
        reply.send(result);
      } catch (err) {
        reply.status(500).send(err);
      }
    }
  })

  fastify.get("/", {
    handler: async (request, reply) => {
      try {
        let query = db("kriteria as k")
          .leftJoin("subkriteria as sk", "k.id", "sk.id_kriteria")
          .select([
            "k.id",
            "k.nama",
            "k.bobot",
            db.raw(`
              JSON_ARRAYAGG(
                JSON_OBJECT(
                  "id", sk.id, 
                  "nama", sk.nama,
                  "core", sk.core,
                  "bobot", sk.bobot
                )
              ) as subs
            `)
          ])
          .groupBy("k.id");
        let items = await query;
        items = items.map(it => {
          it.subs = JSON.parse(it.subs);
          // if (it.jdata.length == 1 && it.jdata[0].id == null) {
          //   it.subs = [];
          // }
          delete it.jdata;
          return it;
        });
        reply.send(items);
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
        await db("kriteria")
          .where("id", "=", id)
          .delete();
        reply.send("ok");
      } catch (err) {
        reply.status(500).send(err);
      }
    }
  })


}