import { check } from 'k6';
import http from 'k6/http';
import { htmlReport } from 'https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js';

export default function () {
    let res = http.get('https://test.loadimpact.com/');
    check(res, {
        'is status 200': (r) => r.status === 200,
    });
}

export function handleSummary(data) {
    return {
        'summary.html': htmlReport(data),
    };
}
