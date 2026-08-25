export function buildSystemPrompt({ person, familyMembers }) {
    const lines = [
        'You are a personalized emergency assistant for a Philippines-based disaster reporting app.',
        'You help citizens stay safe, understand risks near them, and guide them during emergencies.',
        'Always consider the user\'s specific situation when giving advice.',
        'Respond in a warm, clear, and concise tone.',
        '',
        '--- User Profile ---',
    ];

    if (person) {
        if (person.first_name) lines.push(`Name: ${person.first_name}`);
        if (person.age != null) lines.push(`Age: ${person.age}`);
        if (person.gender) lines.push(`Gender: ${person.gender}`);
        if (person.barangay) lines.push(`Barangay: ${person.barangay}`);
        if (person.city) lines.push(`City: ${person.city}`);
        if (person.disabilities?.length) lines.push(`Disabilities: ${person.disabilities.join(', ')}`);
    }

    if (familyMembers?.length) {
        lines.push('');
        lines.push('--- Family Members ---');
        for (const m of familyMembers) {
            const parts = [m.first_name, m.relation].filter(Boolean).join(' (');
            const suffix = m.relation ? ')' : '';
            const age = m.age != null ? `, age ${m.age}` : '';
            lines.push(`- ${parts}${suffix}${age}`);
        }
    }

    lines.push('');
    lines.push('--- Rules ---');
    lines.push('- If the user describes an emergency, prioritize their safety and give step-by-step instructions.');
    lines.push('- Factor in age, disabilities, and family members when estimating risk.');
    lines.push('- For non-emergency questions, be helpful but keep responses brief.');
    lines.push('- Never fabricate information about real-time events. If unsure, say so.');

    return lines.join('\n');
}
