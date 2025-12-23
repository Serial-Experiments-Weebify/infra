function getSecret(name) {
    try {
        const file = process.env[`${name}_FILE`];
        if (file) {
            const r = fs.readFileSync(file, "utf8").trim();
            return r;
        }
    } catch { }

    const value = process.env[name];
    if (value) {
        return value;
    }

    throw new Error(`Secret ${name} not found`);
}

// root
const rootUsername = process.env.MONGO_INITDB_ROOT_USERNAME;
const rootPassword = getSecret('MONGO_INITDB_ROOT_PASSWORD');

// user for backend
const dbWeebifyUser = process.env.DB_WEEBIFY_USERNAME;
const dbWeebifyPass = getSecret('DB_WEEBIFY_PASSWORD');

// weebify user
const adminUsername = process.env.WEEBIFY_USER;
const adminPasswordHash = process.env.WEEBIFY_PASSWORD_HASH;


// User to create
const userDocument = {
    _id: ObjectId(),
    bio: "",
    role: "GOD",
    inviteCodes: [],
    username: adminUsername,
    displayName: adminUsername,
    pfp: "default",
    passwordHash: adminPasswordHash,
    following: [],
    sessions: [],
};

const adminDb = db.getSiblingDB("admin");
adminDb.auth(rootUsername, rootPassword);

db.createUser({
    user: dbWeebifyUser,
    pwd: dbWeebifyPass,
    roles: [{ role: "readWrite", db: "weebify" }],
});

db = db.getSiblingDB("weebify");

db.users.insertOne(userDocument);

db = db.getSiblingDB("admin");

db.createUser({
    user: dbWeebifyUser,
    pwd: dbWeebifyPass,
    roles: [{ role: "readWrite", db: "weebify" }],
});
