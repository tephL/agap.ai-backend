import cors from 'cors';

const allowedOrigins = [
    'http://localhost:3000',   
    'http://localhost:5173',  
    'http://localhost:8081', 
    'http://localhost:19006',
];

export default cors({
    origin: (origin, cb) => {
        if(!origin || allowedOrigins.includes(origin)){
            cb(null, true);
        } else{
            cb(new Error('Not allowed'));
        }
    },
    credentials: true
});
