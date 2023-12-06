import { check, sleep } from 'k6';
import http, { get } from 'k6/http';
import { htmlReport } from 'https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js';
import { SharedOptions, TestUser } from './Shared.js';
import {
    generateRandomString,
    getAuthenticatedRequestHeaders,
} from './utils.js';

export let options = SharedOptions;
let header = null;
export const setup = async () => {
    header = await getAuthenticatedRequestHeaders();
    return header;
};
export default function (header) {
    let payload = JSON.stringify({
        username: generateRandomString(10),
    });
    let response = http.patch(
        'http://localhost:3000/api/v1/users/updateUserName',
        payload,
        {
            headers: header,
        }
    );

    check(response, {
        'is status 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function handleSummary(data) {
    return {
        '../reports/UpdateUserName.html': htmlReport(data),
    };
}
