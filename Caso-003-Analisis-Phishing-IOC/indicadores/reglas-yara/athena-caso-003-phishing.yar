rule ATHENA_CASO_003_Phishing_Simulado
{
    meta:
        description = "Detecta indicadores de la simulacion de phishing CASO-003"
        author = "Athena Labs"
        date = "2026-07-13"
        severity = "high"
        classification = "controlled-simulation"

    strings:
        $domain_1 = "micros0ft-support.example" ascii nocase
        $domain_2 = "login-microsoft.example" ascii nocase
        $domain_3 = "account-verify.example" ascii nocase
        $domain_4 = "mailer-phishing.example" ascii nocase

        $auth_1 = "spf=fail" ascii nocase
        $auth_2 = "dmarc=fail" ascii nocase
        $auth_3 = "dkim=none" ascii nocase

        $urgency_1 = "24 horas" ascii nocase
        $urgency_2 = "cuenta sera suspendida" ascii nocase

        $html_link = "href=" ascii nocase
        $lab_marker = "ATHENA LABS" ascii nocase

    condition:
        (3 of ($domain_*) and 1 of ($auth_*) and 1 of ($urgency_*)) or
        ($html_link and 1 of ($domain_*) and $lab_marker)
}
