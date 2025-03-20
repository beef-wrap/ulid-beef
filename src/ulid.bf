/* ULID generation and parsing library (API)
 *
 * This is free and unencumbered software released into the public domain.
 */

using System;
using System.Interop;

namespace ulid;

public static class ulid
{
	typealias char = c_char;

	/* Generator configuration flags */
	public const c_int ULID_RELAXED   = 1 << 0;
	public const c_int ULID_PARANOID  = 1 << 1;
	public const c_int ULID_SECURE    = 1 << 2;

	[CRepr]
	public struct ulid_generator
	{
		c_uchar[16] last;
		c_ulonglong last_ts;
		c_int flags;
		c_uchar i, j;
		c_uchar[256] s;
	}

	/* Initialize a new ULID generator instance.
	*
	* The ULID_RELAXED flag allows ULIDs generated within the same
	* millisecond to be non-monotonic, e.g. the random section is generated
	* fresh each time.
	*
	* The ULID_PARANOID flag causes the generator to clear the highest bit
	* of the random field, which guarantees that overflow cannot occur.
	* Normally the chance of overflow is non-zero, but negligible. This
	* makes it zero. It doesn't make sense to use this flag in conjunction
	* with ULID_RELAX.
	*
	* The ULID_SECURE flag doesn't fall back on userspace initialization if
	* system entropy could not be gathered. You _must_ check the return
	* value if you use this flag, since it now indicates a hard error.
	*
	* Returns 0 if the generator was successfully initialized from secure
	* system entropy. Returns 1 if this failed and instead derived entropy
	* in userspace (or is uninitialized in the case of ULID_SECURE).
	*/
	[CLink] public static extern c_int ulid_generator_init(ulid_generator*, c_int flags);

	/* Generate a new ULID.
	* A zero terminating byte is written to the output buffer.
	*/
	[CLink] public static extern void ulid_generate(ulid_generator*, char[27]);

	/* Encode a 128-bit binary ULID to its text format.
	* A zero terminating byte is written to the output buffer.
	*/
	[CLink] public static extern void ulid_encode(char[27], c_uchar[16]);

	/* Decode a text ULID to a 128-bit binary ULID.
	* Returns non-zero if input was invalid.
	*/
	[CLink] public static extern c_int ulid_decode(c_uchar[16], char*);
}