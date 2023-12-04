import { check, sleep } from 'k6';

import http from 'k6/http';
import { htmlReport } from 'https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js';

export let options = {
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
            target: 700,
        },
        {
            duration: '10s',
            target: 700,
        },
        {
            duration: '50s',
            target: 0,
        },
    ],
};

export default function () {
    let payload = JSON.stringify({
        UUID: 'Art@gmail.com',
        password: '12345678tT@',
    });

    let headers = {
        'Content-Type': 'application/json',
    };

    let response = http.post(
        'http://localhost:3000/api/v1/auth/login',
        payload,
        {
            headers: headers,
        }
    );

    check(response, {
        'is status 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function handleSummary(data) {
    return {
        'summary.html': htmlReport(data),
    };
}
