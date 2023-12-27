import { check, sleep } from 'k6';

import http from 'k6/http';
import { htmlReport } from 'https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js';
import { SharedOptions, TestUser } from './Shared.js';

export let options = SharedOptions;
let header = null;
export const setup = async () => {
    header = await getAuthenticatedRequestHeaders();
    return header;
};
export default function () {
    let payload = JSON.stringify({
        password: "12345678aA@",
    });

    let response = http.post(
        'http://localhost:3000/api/v1/auth/resetPassword/emannn/0e187534',
        payload,
        {
            headers: header,
        }
    );
    sleep(1);
}

export function handleSummary(data) {
    return {
        '../reports/ResetPassword.html': htmlReport(data),
    };
}
