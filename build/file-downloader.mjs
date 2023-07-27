import process from 'node:process';
import Minio from 'minio';

function download(bucket, fileName, destination, accessKey, secretKey) {
    const minioClient = new Minio.Client({
        endPoint: 'minio.minio-operator',
        port: 80,
        useSSL: false,
        accessKey: accessKey,
        secretKey: secretKey,
    });

    minioClient.fGetObject(bucket, fileName, destination, function (err) {
        if (err) {
            console.log(err);
            process.exit(1);
        }
        console.log(`downloaded ${fileName} from ${bucket}`);
    })
}

function main() {
    const ACCESS_KEY = process.env.ACCESS_KEY;
    const SECRET_KEY = process.env.SECRET_KEY;
    if (!SECRET_KEY) {
        console.log('SECRET_KEY environment variable is not set');
        process.exit(1);
    }

    if (!SECRET_KEY) {
        console.log('ACCESS_KEY environment varibale is not set');
        process.exit(1);
    }
    const args = process.argv.slice(2);
    const bucket = args[0];
    const fileName = args[1];
    const destination = args[2];

    download(bucket, fileName, destination, ACCESS_KEY, SECRET_KEY);
}

main();
