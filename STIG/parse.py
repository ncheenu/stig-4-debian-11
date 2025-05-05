import sys
import xml.etree.ElementTree as ET
import html

content_by_sev_g = {
    "high": [],
    "medium": [],
    "low": []
}

# Load and parse XML
tree = ET.parse(sys.argv[1])
root = tree.getroot()

# Extract namespace dynamically
for elem in root.iter():
    if elem.tag.endswith('Benchmark'):
        xmlns = elem.tag.split('}')[0].strip('{')
        break
ns = {'xccdf': xmlns}

# Get all idrefs (Group IDs) under MAC-1_Public profile
profile = root.find(f".//xccdf:Profile[@id='{sys.argv[2]}']", ns)
group_ids = {s.attrib['idref'] for s in profile.findall("xccdf:select", ns)}

# Traverse all Groups and extract desired fields
for group in root.findall(".//xccdf:Group", ns):
    group_id = group.attrib.get('id')
    if group_id in group_ids:
        rule = group.find("xccdf:Rule", ns)
        if rule is not None:
            rule_id = rule.attrib.get('id')
            severity = rule.attrib.get('severity', 'N/A')
            title = rule.findtext("xccdf:title", default="N/A", namespaces=ns)
            description = rule.findtext("xccdf:description", default="N/A", namespaces=ns)
            fixtext_elem = rule.find("xccdf:fixtext", ns)
            fixtext = fixtext_elem.text.strip() if fixtext_elem is not None else "N/A"
            check_elem = rule.find("xccdf:check", ns)
            check_content_text = "Unable to find check-content"
            if check_elem:
                check_content = check_elem.find("xccdf:check-content", ns)
                if check_content is not None:
                    check_content_text = check_content.text.strip()

            content_by_sev_g[severity.lower()].append({
                    "group_id": group_id,
                    "rule_id": rule_id,
                    "severity": severity,
                    "title": title,
                    "description": description,
                    "check-content": check_content_text,
                    "fixtext": fixtext
            })

# Traverse and print
with open(sys.argv[3], "w") as f:
    for cat_list in content_by_sev_g.values():
        for cat_ent in cat_list:
            f.write(f"Rule ID: {cat_ent['rule_id']}\n")
            f.write(f"Severity: {cat_ent['severity']}\n")
            f.write(f"Rule Title: {cat_ent['title']}\n")
            f.write(f"Description: {html.escape(cat_ent['description'])}\n")
            f.write(f"Check_content: {cat_ent['check-content']}\n")
            f.write(f"Fixtext: {cat_ent['fixtext']}\n")
            f.write("\n")  # One line breaks between rules
