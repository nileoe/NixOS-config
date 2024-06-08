{ config, pkgs, ...}:
{
    services.cron = {
        enable = true;
        systemCronJobs = [
            "*/1 * * * *      root    batteryNotify
        ];
    };
}
