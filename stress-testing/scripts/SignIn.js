import { check } from 'k6';

import http from 'k6/http';
import { htmlReport } from 'https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js';

export let options = {
    vus: 2,
    duration: '30s',
};

export default function () {
    let payload = JSON.stringify({
        UUID: 'Claudie@gmail.com',
        password: '12345678tT@',
    });

    let headers = {
        'Content-Type': 'application/json',
    };

    let response = http.post(
        'http://16.171.65.142:3000/api/v1/auth/login',
        payload,
        {
            headers: headers,
        }
    );

    check(response, {
        'is status 200': (r) => r.status === 200,
    });
}

export function handleSummary(data) {
    return {
        'summary.html': htmlReport(data),
    };
}
