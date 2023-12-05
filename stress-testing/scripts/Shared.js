const SharedOptions = {
  thresholds: {
    http_req_duration: [{ threshold: "p(95) < 20000" }],
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
    UUID: "76a2bc6d-260d-4d21-84ee-e8aac0d61536@email.webhook.site",
    password: "12345678tT@",
  },
];

const TestUserData = {
  name: "TestName",
  password: "12345678tT@",
  email: "76a2bc6d-260d-4d21-84ee-e8aac0d61536@email.webhook.site",
  birthdayDate: "10-17-2023",
  emailVerificationToken: "931d7329",
};

export { SharedOptions, TestUser, TestUserData };
