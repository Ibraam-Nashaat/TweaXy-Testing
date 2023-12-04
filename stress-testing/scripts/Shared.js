const SharedOptions = {
    thresholds: {
        http_req_duration: [{ threshold: 'p(95) < 20000', abortOnFail: true }],
    },
    stages: [
        {
            duration: '10s',
            target: 100,
        },
        {
            duration: '50s',
            target: 900,
        },
        {
            duration: '10s',
            target: 900,
        },
        {
            duration: '50s',
            target: 0,
        },
    ],
};

const TestUser = [
    {
        UUID: 'Bessie@gmail.com',
        password: '12345678tT@',
    },
];

export { SharedOptions, TestUser };
