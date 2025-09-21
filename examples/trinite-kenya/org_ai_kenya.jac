node Org {
    has id: str,
        name: str;
}

node Site {
    has id: str,
        name: str,
        county: str,
        town: str,
        status: str = "active";
}
node Person {
    has id: str,
        name: str,
        role: str,
        department: str,
        email: str,
        join_date: str,
        county: str;
}
node Project {
    has id: str,
        name: str,
        start_date: str,
        end_date: str,
        status: str;      # active | paused | closed
}

node Task {
    has id: str,
        title: str,
        due_date: str,
        status: str,      # completed | overdue | in_progress
        assignee_id: str,
        project_id: str;
}
node Signal {
    has id: str,
        person_id: str,
        kind: str,     # attendance_pct | tasks_overdue | email_response_hours
        value: float,
        timestamp: str;
}
    # scoring weights
    let w_att = 50.0;       # low attendance
    let w_od  = 50.0;       # overdue tasks
    let w_em  = 25.0;       # slow email

with entry {
    # Create nodes
    let org = Org(id="ORG-KE", name="Project Trinite Kenya");
    root ++> org;

    let s_eld = Site(id="SITE-ELD", name="Trinite POD - Eldoret", county="Uasin Gishu", town="Eldoret");
    root ++> s_eld;

    let s_kap = Site(id="SITE-KAP", name="Trinite POD - Kapenguria", county="West Pokot", town="Kapenguria");
    root ++> s_kap;

    # Connect using generic edges (works on 0.8.7)
    org ++> s_eld;
    org ++> s_kap;
    # People
    let p1 = Person(
        id="P1",
        name="Nancy",
        role="Associate",
        department="Digital Skills",
        email="nancy@demo.local",
        join_date="2024-01-15",
        county="Uasin Gishu"
    );
    root ++> p1;

    let p2 = Person(
        id="P2",
        name="Marko",
        role="Regional Director",
        department="Management",
        email="marko@demo.local",
        join_date="2023-10-01",
        county="Nairobi"
    );
    root ++> p2;

    let p3 = Person(
        id="P3",
        name="Valary",
        role="Trainer",
        department="Digital Skills",
        email="valary@demo.local",
        join_date="2024-06-10",
        county="West Pokot"
    );
    root ++> p3;

    # Link people to sites (generic edges)
    p1 ++> s_eld;
    p2 ++> s_kap;
    p3 ++> s_kap;

    print("People: " + p1.name + " | " + p2.name + " | " + p3.name);
    # Projects
    let j1 = Project(
        id="J1",
        name="Digital Training Pilot - Eldoret",
        start_date="2025-01-01",
        end_date="2025-03-30",
        status="active"
    );
    root ++> j1;

    let j2 = Project(
        id="J2",
        name="Artisan Marketplace - West Pokot",
        start_date="2025-02-01",
        end_date="2025-04-30",
        status="active"
    );
    root ++> j2;

    # link org -> projects (generic edges)
    org ++> j1;
    org ++> j2;

    # assign people to projects (generic edges)
    p1 ++> j1;    # Nancy on Eldoret pilot
    p3 ++> j1;    # Valary on Eldoret pilot
    p2 ++> j2;    # Marko on Marketplace

    print("Projects: " + j1.name + " | " + j2.name);

    # Tasks
    let t1 = Task(
        id="T1",
        title="Prepare Eldoret curriculum v1",
        due_date="2025-01-20",
        status="completed",
        assignee_id="P1",
        project_id="J1"
    );
    root ++> t1;

    let t2 = Task(
        id="T2",
        title="Onboard West Pokot vendors",
        due_date="2025-02-15",
        status="overdue",
        assignee_id="P2",
        project_id="J2"
    );
    root ++> t2;

    let t3 = Task(
        id="T3",
        title="Set up POD equipment - Kapenguria",
        due_date="2025-02-10",
        status="in_progress",
        assignee_id="P3",
        project_id="J1"
    );
    root ++> t3;

    # connect tasks to assignees and projects (generic edges)
    t1 ++> p1;  t1 ++> j1;
    t2 ++> p2;  t2 ++> j2;
    t3 ++> p3;  t3 ++> j1;

    print("Tasks: " + t1.title + " | " + t2.title + " | " + t3.title);
    # --- Signals (attach to graph + link to persons) ---
    let s1 = Signal(id="S1", person_id="P1", kind="attendance_pct", value=82.0, timestamp="2025-01-19");
    root ++> s1;   p1 ++> s1;

    let s2 = Signal(id="S2", person_id="P2", kind="tasks_overdue", value=3.0, timestamp="2025-02-16");
    root ++> s2;   p2 ++> s2;

    let s3 = Signal(id="S3", person_id="P1", kind="email_response_hours", value=48.0, timestamp="2025-01-20");
    root ++> s3;   p1 ++> s3;

    let s4 = Signal(id="S4", person_id="P3", kind="attendance_pct", value=68.0, timestamp="2025-02-12");
    root ++> s4;   p3 ++> s4;

    # --- simple thresholds ---
    let attendance_low_pct = 75.0;
    let overdue_tasks_high = 2.0;
    let slow_email_hours   = 36.0;
    # ---- simple thresholds (you already have these) ----
    let attendance_low_pct = 75.0;
    let overdue_tasks_high = 2.0;
    let slow_email_hours   = 36.0;

        # ---- FILTER KNOBS ----
    let show_only_label   = "Medium";  # "", "High", "Medium", "Low"
    let filter_county     = "";
    let filter_project_id = "";

    # map each person to a project (matches your assignments)
    let p1_proj_id = "J1";   # Nancy on Eldoret pilot
    let p2_proj_id = "J2";   # Marko on Marketplace
    let p3_proj_id = "J1";   # Valary on Eldoret pilot
    # ---- thresholds ----
    let attendance_low_pct = 75.0;
    let overdue_tasks_high = 2.0;
    let slow_email_hours   = 36.0;

    # ---- FILTER KNOBS ----
    let show_only_label   = "High";   # "", "High", "Medium", "Low"
    let filter_county     = "";       # e.g., "West Pokot"
    let filter_project_id = "";       # "J1" or "J2"

    # person -> project mapping (matches your assignments)
    let p1_proj_id = "J1";   # Nancy
    let p2_proj_id = "J2";   # Marko
    let p3_proj_id = "J1";   # Valary

   print("\n--- Risk Report (rules-first) ---");

# thresholds
let attendance_low_pct = 75.0;
let overdue_tasks_high = 2.0;
let slow_email_hours   = 36.0;

# FILTER KNOBS (set these as you like)
let show_only_label   = "";        # "", "High", "Medium", "Low"
let filter_county     = "";        # e.g., "West Pokot"
let filter_project_id = "";        # "J1" or "J2"

# person -> project mapping (matches your assignments earlier)
let p1_proj_id = "J1";   # Nancy
let p2_proj_id = "J2";   # Marko
let p3_proj_id = "J1";   # Valary

# ---------- Nancy (P1) ----------
let reasons1 = [];
if (s1.value < attendance_low_pct) { reasons1 += ["low attendance (" + str(s1.value) + "%)"]; }
if (s3.value > slow_email_hours)   { reasons1 += ["slow email response (" + str(s3.value) + "h)"]; }

let score1 = 0.0;
if (s1.value < attendance_low_pct) { score1 = score1 + 50.0; }
if (s3.value > slow_email_hours)   { score1 = score1 + 25.0; }

let label1 = "Low";
if (score1 >= 75.0) { label1 = "High"; } else { if (score1 >= 40.0) { label1 = "Medium"; } }

let show1 = ((show_only_label == "") or (label1 == show_only_label))
            and ((filter_county == "") or (p1.county == filter_county))
            and ((filter_project_id == "") or (p1_proj_id == filter_project_id));

if (reasons1 != [] and show1) {
    print("* " + p1.name + " - " + p1.role + " | County: " + p1.county);
    print("  Reasons: " + str(reasons1));
    print("  Score: " + str(score1) + " (" + label1 + ")");
    print("  Suggested actions: ['Set email SLAs; quick stand-up']");
}

# ---------- Marko (P2) ----------
let reasons2 = [];
if (s2.value > overdue_tasks_high) { reasons2 += [str(s2.value) + " overdue tasks"]; }

let score2 = 0.0;
if (s2.value > overdue_tasks_high) { score2 = score2 + 50.0; }

let label2 = "Low";
if (score2 >= 75.0) { label2 = "High"; } else { if (score2 >= 40.0) { label2 = "Medium"; } }

let show2 = ((show_only_label == "") or (label2 == show_only_label))
            and ((filter_county == "") or (p2.county == filter_county))
            and ((filter_project_id == "") or (p2_proj_id == filter_project_id));

if (reasons2 != [] and show2) {
    print("* " + p2.name + " - " + p2.role + " | County: " + p2.county);
    print("  Reasons: " + str(reasons2));
    print("  Score: " + str(score2) + " (" + label2 + ")");
    print("  Suggested actions: ['Balance workload / reassign tasks']");
}

# ---------- Valary (P3) ----------
let reasons3 = [];
if (s4.value < attendance_low_pct) { reasons3 += ["low attendance (" + str(s4.value) + "%)"]; }

let score3 = 0.0;
if (s4.value < attendance_low_pct) { score3 = score3 + 50.0; }

let label3 = "Low";
if (score3 >= 75.0) { label3 = "High"; } else { if (score3 >= 40.0) { label3 = "Medium"; } }

let show3 = ((show_only_label == "") or (label3 == show_only_label))
            and ((filter_county == "") or (p3.county == filter_county))
            and ((filter_project_id == "") or (p3_proj_id == filter_project_id));

if (reasons3 != [] and show3) {
    print("* " + p3.name + " - " + p3.role + " | County: " + p3.county);
    print("  Reasons: " + str(reasons3));
    print("  Score: " + str(score3) + " (" + label3 + ")");
    print("  Suggested actions: ['Mentor check-in at West Pokot site']");
}


    print("OK: " + org.name + " with 2 sites.");
}
