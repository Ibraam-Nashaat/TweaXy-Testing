const SharedOptions = {
  thresholds: {
    http_req_duration: [{ threshold: "p(95) < 20000", abortOnFail: true }],
  },
  stages: [
    {
      duration: "10s",
      target: 100,
    },
    {
      duration: "50s",
      target: 900,
    },
    {
      duration: "10s",
      target: 900,
    },
    {
      duration: "50s",
      target: 0,
    },
  ],
};

const TestUser = [
  {
    UUID: "micheal123456@gmail.com",
    password: "12345678tT@",
  },
];

const TestUserData = {
  name: "TestName",
  password: "12345678tT@",
  email: "micheal123456@gmail.com",
  birthdayDate: "10-17-2023",
  emailVerificationToken: "931d7329",
};

export { SharedOptions, TestUser, TestUserData };
