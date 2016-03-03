#include <iostream>
#include <algorithm>
#include <vector>
#include <map>
#include <set>
#include <string>
#include <cctype>
#include <queue>

bool
begins_with(const std::string& s, const std::string& t)
{
    if (0 == s.compare(0, t.length(), t)) return true;
    return false;
}

bool
begins_with(const std::string& s, const std::string& t,
            std::string& rest)
{
    if (begins_with(s, t)) {
        rest = s.substr(t.length(), std::string::npos);
        return true;
    }
    return false;
}

size_t
get_extension(const std::string& s)
{
    size_t x = s.find_last_of('.');
    if (x == std::string::npos) return x;
    ++x;
    if (std::all_of(s.cbegin() + x, s.cend(), isalnum)) return x;
    return std::string::npos;
}

int
main()
{
    std::string s, name;
    std::vector<std::string> lines{};
    std::map<std::string, std::set<std::string>> uses{};
    std::map<std::string, std::string> chunk_lang{};

    std::map<std::string, std::string> langs{
        {"pl", "prolog"},
        {"sh", "bash"},
        {"bash", "bash"},
        {"cpp", "cpp"},
        {"R", "R"},
        {"awk", "awk"},
        {"sed", "sed"},
        {"css", "css"}};

    std::queue<std::string> pending{};
    
out:
{
    if (!std::getline(std::cin, s)) goto end;
    lines.push_back(s);
    if (begins_with(s, {"@begin code"})) goto code;
    goto out;
}

code:
{
    if (!std::getline(std::cin, s)) goto error;
    lines.push_back(s);

    if (begins_with(s, {"@defn "}, name)) {
        uses.insert({name, {}}); // insert if not already there

        size_t ext_pos = get_extension(name);
        if (ext_pos != std::string::npos) {
            std::string ext = name.substr(ext_pos);
            auto lang = langs.find(ext);
            if (lang != langs.cend()) {
                chunk_lang.insert({name, lang->second});
                pending.push(name);
            }
        }
        goto name;
    }

    goto code;
}

name:
{
    if (!std::getline(std::cin, s)) goto error;
    lines.push_back(s);
    std::string use_name;

    if (begins_with(s, {"@use "}, use_name)) {
        uses[name].insert(use_name);
        goto name;
    }

    if (begins_with(s, {"@end code"})) goto out;
    goto name;
}

end:
{
    while (!pending.empty()) {
        std::string next = pending.front();
        pending.pop();

        std::set<std::string> candidates = uses[next];

        for (auto c : candidates) {
            auto x = chunk_lang.find(c);
            if (x == chunk_lang.cend()) {
                chunk_lang.insert({c, chunk_lang[next]});
                pending.push(c);
            }
        }
    }

    for (auto l : lines) {
        std::cout << l << '\n';

        if (begins_with(l, {"@defn "}, name)) {
            auto x = chunk_lang.find(name);
            if (x != chunk_lang.cend()) {
                std::cout << "@language " << x->second << '\n';
            } else std::cout << "@language txt\n";
        }
    }

    return 0;
}

error: return 1;
}
