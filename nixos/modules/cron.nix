{ config, pkgs, ...}:
{
    services.cron = {
        enable = true;
        systemCronJobs = [
            "*/3 * * * *      root    batteryNotify"
        ];
    };
}
