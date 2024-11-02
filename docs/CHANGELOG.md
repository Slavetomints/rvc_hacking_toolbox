## Version History

### 0.4.1 Patch
- Changed seperate(d) to separate(d)

### 0.4.0 Update

**New Features:**
- Wordlist enhancer mode can do the following:
  - Make Leetspeak variants of words
  - Append/Prepend numbers
  - Replace characters/phrases

**Additions**
- Added ` tty-prompt ` to the [Gemfile](../Gemfile)
- Added [docs](../docs/) directory that includes:
  - [README](/docs/README.md) file
  - [Version History](/docs/CHANGELOG.md)
  - [Usage Guide](/docs/USAGE.md)
  - [License](/docs/LICENSE)

**Other Improvements**
- Cryptography
  - Fixed spelling of "caesar" that was causing error when trying to call its ascii art.
  - Fixed logic error in caesar.rb causing uppercase letters to show up twice
  - Decimal and RSA decoding now uses spaces as the delimiter

---
### 0.3.0 Update

**New Features:**
- Added capabilities to scan over NGINX, AWS S3, and Squid Logs

---
### 0.2.0 Update

**New Features:**
- Easier File Selection in Metadata: Implemented a more user-friendly file selection process for metadata scanning.

**Enhancements:**
- Error Handling: Added more comprehensive error handling to improve stability and user experience.
- [Comprehensive Scan](/lib/web_application_exploitation/comprehensive_scan/): Enhanced the scan file functionality, including improvements to display and output.

**Removals:**
- SQL Injection Scan Capabilities: Removed SQL injection scan capabilities to streamline the tool.

**Additions:**
- PHP Includes Statements Support: Added support for scanning for PHP includes statements.
- Requests Support: Introduced support for handling requests.
- Comment Support: Enhanced the tool to better handle comments in code.

**Other Improvements:**
- Robots.txt Scanner: Continued work on the robots.txt scanner for better web application analysis.

---
### 0.1.1. Update

**New Features:**
- Introduced new titles and improved the logic for displaying them.

**Improvements:**
- Enhanced error handling to prevent unexpected program quits.
- Refined menu handling with tty-prompt for a cleaner interface, eliminating most case switch statements.

**Enhancements:**
- Continued development on the comprehensive scan mode.
