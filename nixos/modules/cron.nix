{ config, pkgs, ...}:
{
    services.cron = {
        enable = true;
        systemCronJobs = [
            "*/1 * * * *      root    date >> /tmp/cron.log"
        ];
    };
}
